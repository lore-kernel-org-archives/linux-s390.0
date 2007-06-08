Return-Path: <linux-kernel-owner+w=401wt.eu-S1031031AbXFHRO1@vger.kernel.org>
Message-ID: <46698E50.6030108@de.ibm.com>
Date: Fri, 08 Jun 2007 19:13:52 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
References: <1181165656.7133.23.camel@dix> <1181202683.7348.220.camel@twins>
In-Reply-To: <1181202683.7348.220.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Peter Zijlstra wrote:
> On Wed, 2007-06-06 at 23:34 +0200, Martin Peschke wrote:
> 
>> +struct statistic_info lock_stat_info[_LOCK_STAT_NUMBER] = {
>> +	[LOCK_STAT_CONT] = {
>> +		.name	  = "contentions",
>> +		.x_unit	  = "instruction_pointer",
>> +		.y_unit	  = "occurrence",
>> +		.defaults = "type=sparse entries=4",
>> +		.flags	  = STATISTIC_FLAGS_LABEL,
>> +	},
>> +	[LOCK_STAT_WAIT_READ] = {
>> +		.name	  = "wait_read",
>> +		.x_unit	  = "nanoseconds",
>> +		.y_unit	  = "occurrence",
>> +		.defaults = "type=utilisation",
>> +	},
>> +	[LOCK_STAT_WAIT_WRITE] = {
>> +		.name	  = "wait_write",
>> +		.x_unit	  = "nanoseconds",
>> +		.y_unit	  = "occurrence",
>> +		.defaults = "type=utilisation",
>> +	},
>> +	[LOCK_STAT_HOLD_READ] = {
>> +		.name	  = "hold_read",
>> +		.x_unit	  = "nanoseconds",
>> +		.y_unit	  = "occurrence",
>> +		.defaults = "type=utilisation",
>> +	},
>> +	[LOCK_STAT_HOLD_WRITE] = {
>> +		.name	  = "hold_write",
>> +		.x_unit	  = "nanoseconds",
>> +		.y_unit	  = "occurrence",
>> +		.defaults = "type=utilisation",
>>  	}
>>  };
> 
> You're parsing strings in-kernel to setup data structures?

Might be surprising (or revolting?)... but, yes, I do.

.defaults reflects the developers opinion on the way of data
accumululation that might make most sense in most cases.
The current implementation of lib/statistic.c allows users to change
setting that we see in .defaults. If one needs to track more than
4 contention points, for example, then they can change this limit by
passing "entries=4" to the user interface. So there is some parsing
code anyway. Passing default setting in a similar fashion has just been
convenient for the developer.
