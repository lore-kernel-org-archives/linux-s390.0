Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/2] s390/perf: fix perf annotate error -95 (4.10
 regression)
References: <1491465112-45819-1-git-send-email-borntraeger@de.ibm.com>
 <1491465112-45819-2-git-send-email-borntraeger@de.ibm.com>
 <20170407152341.GB2388@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Apr 2017 11:18:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170407152341.GB2388@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <0247c7c8-60d5-f267-78e8-89863b4711af@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 04/07/2017 05:23 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 06, 2017 at 09:51:51AM +0200, Christian Borntraeger escreveu:
>> since 4.10 perf annotate exits on s390 with an "unknown error -95".
>> Turns out that commit 786c1b51844d ("perf annotate: Start supporting
>> cross arch annotation") added a hard requirement for architecture
> 
> Argh, that was unfortunate, I'll apply your patches and try to remove
> that restriction, using the defaults previously in place :-\

Is there a chance to get this fix into 4.11? (the 2nd patch can certainly wait
for the next merge window)

> 
> thanks,
> 
> - Arnaldo
> 
> 
>> support when objdump is used but only provided x86 and arm
>> support. Meanwhile power was added so lets add s390 as well.
>>
>> While at it make sure to implement the branch and jump types.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Fixes: 786c1b51844 "perf annotate: Start supporting cross arch annotation"
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>>  tools/perf/util/annotate.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 273f21f..7aa5722 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -130,6 +130,12 @@ static struct arch architectures[] = {
>>  		.name = "powerpc",
>>  		.init = powerpc__annotate_init,
>>  	},
>> +	{
>> +		.name = "s390",
>> +		.objdump =  {
>> +			.comment_char = '#',
>> +		},
>> +	},
>>  };
>>  
>>  static void ins__delete(struct ins_operands *ops)
>> -- 
>> 2.7.4
> 
