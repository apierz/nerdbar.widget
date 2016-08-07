command: """
    sar -n DEV 1 1 2> /dev/null |
    grep '[0-9].*en[0-9]' |
    {
    while read -r line;
    do
        downBytes=$(($downBytes + $(echo $line | awk '{down=$4} END {print down}')));
        upBytes=$(($upBytes + $(echo $line | awk '{up=$6} END {print up}')));
        result=$(echo "$downBytes $upBytes");
    done
    echo $result;
    }
"""
refreshFrequency: 3000

style: """
    -webkit-font-smoothing: antialiased
    widget-align = center
    left: 42.5%
    width: 15%
    top: 5px
   
    color #f8f8f2
    font: 12px Hack

    .stats-container
        width: 100%
        margin-bottom 5px
        border-collapse collapse
    td
        font-size: 12px
        color: rgba(#8be9fd)
        text-align: center
    .up
        color: #ff5555
  
"""

render: -> """
    <div class="container">
        <table class="stats-container">
            <tr>
                <td class="stat"><span class="down"></span></td>
                <td class="stat"><span class="up"></span></td>
            </tr>
        </table>
    </div>
"""

update: (output, domEl) ->

    usage = (bytes) ->
        kb = bytes / 1024
        usageFormat kb

    usageFormat = (kb) ->
        if kb > 1024
            mb = kb / 1024
            "#{parseFloat(mb.toFixed(1))} MB/s"
        else
            "#{parseFloat(kb.toFixed(2))} KB/s"

    updateStat = (sel, currBytes, totalBytes) ->
        percent = (currBytes / totalBytes * 100).toFixed(1) + "%"
        $(domEl).find(".#{sel}").text usage(currBytes)
        $(domEl).find(".bar-#{sel}").css "width", percent

    lines = output.split " "

    downBytes = (Number) lines[0]
    upBytes = (Number) lines[1]

    totalBytes = downBytes + upBytes

    updateStat 'down', downBytes, totalBytes
    updateStat 'up', upBytes, totalBytes
