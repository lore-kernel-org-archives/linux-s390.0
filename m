From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/1] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 17:03:57 +0200
Message-ID: <20160503150356.GE30059@potion>
References: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
 <1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
 <20160503145612.58d8da82.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160503145612.58d8da82.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

2016-05-03 14:56+0200, Cornelia Huck:
> On Tue,  3 May 2016 14:37:21 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>> diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
>> index aa69253..92e6fd6 100644
>> --- a/include/trace/events/kvm.h
>> +++ b/include/trace/events/kvm.h
>> @@ -38,22 +38,25 @@ TRACE_EVENT(kvm_userspace_exit,
>>  );
>> 
>>  TRACE_EVENT(kvm_vcpu_wakeup,
>> -	    TP_PROTO(__u64 ns, bool waited),
>> -	    TP_ARGS(ns, waited),
>> +	    TP_PROTO(__u64 ns, bool waited, bool tuned),
>> +	    TP_ARGS(ns, waited, tuned),
>> 
>>  	TP_STRUCT__entry(
>>  		__field(	__u64,		ns		)
>>  		__field(	bool,		waited		)
>> +		__field(	bool,		tuned		)
>>  	),
>> 
>>  	TP_fast_assign(
>>  		__entry->ns		= ns;
>>  		__entry->waited		= waited;
>> +		__entry->tuned		= tuned;
>>  	),
>> 
>> -	TP_printk("%s time %lld ns",
>> +	TP_printk("%s time %lld ns, polling %s",
>>  		  __entry->waited ? "wait" : "poll",
>> -		  __entry->ns)
>> +		  __entry->ns,
>> +		  __entry->tuned ? "changed" : "unchanged")
> 
> I think "changed"/"unchanged" is a bit misleading here, as we do adjust
> the intervall if we had an invalid poll... but it's hard to find a
> suitable text here.
> 
> Just print "poll interval tuned" if we were (a) polling to begin with,
> (b) the poll was valid and (c) the interval was actually changed and
> print "invalid poll" if that's what happened? Or is that overkill?

Just renaming to valid/invalid is fine, IMO, the state of polling is
static and interval change can be read from other traces.

I think that having "no_tuning" counter, "unchanged" trace and "invalid"
in source names obscures the logical connection;  doesn't "invalid" fit
them all?
