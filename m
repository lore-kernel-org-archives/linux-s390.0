From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 20:12:00 +0200
Message-ID: <5728E9F0.1090705@de.ibm.com>
References: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
 <1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
 <20160503145612.58d8da82.cornelia.huck@de.ibm.com>
 <20160503150356.GE30059@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160503150356.GE30059@potion>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/03/2016 05:03 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2016-05-03 14:56+0200, Cornelia Huck:
>> On Tue,  3 May 2016 14:37:21 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>> diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.=
h
>>> index aa69253..92e6fd6 100644
>>> --- a/include/trace/events/kvm.h
>>> +++ b/include/trace/events/kvm.h
>>> @@ -38,22 +38,25 @@ TRACE_EVENT(kvm_userspace_exit,
>>>  );
>>>
>>>  TRACE_EVENT(kvm_vcpu_wakeup,
>>> -	    TP_PROTO(__u64 ns, bool waited),
>>> -	    TP_ARGS(ns, waited),
>>> +	    TP_PROTO(__u64 ns, bool waited, bool tuned),
>>> +	    TP_ARGS(ns, waited, tuned),
>>>
>>>  	TP_STRUCT__entry(
>>>  		__field(	__u64,		ns		)
>>>  		__field(	bool,		waited		)
>>> +		__field(	bool,		tuned		)
>>>  	),
>>>
>>>  	TP_fast_assign(
>>>  		__entry->ns		=3D ns;
>>>  		__entry->waited		=3D waited;
>>> +		__entry->tuned		=3D tuned;
>>>  	),
>>>
>>> -	TP_printk("%s time %lld ns",
>>> +	TP_printk("%s time %lld ns, polling %s",
>>>  		  __entry->waited ? "wait" : "poll",
>>> -		  __entry->ns)
>>> +		  __entry->ns,
>>> +		  __entry->tuned ? "changed" : "unchanged")
>>
>> I think "changed"/"unchanged" is a bit misleading here, as we do adj=
ust
>> the intervall if we had an invalid poll... but it's hard to find a
>> suitable text here.
>>
>> Just print "poll interval tuned" if we were (a) polling to begin wit=
h,
>> (b) the poll was valid and (c) the interval was actually changed and
>> print "invalid poll" if that's what happened? Or is that overkill?
>=20
> Just renaming to valid/invalid is fine, IMO, the state of polling is
> static and interval change can be read from other traces.
>=20
> I think that having "no_tuning" counter, "unchanged" trace and "inval=
id"
> in source names obscures the logical connection;  doesn't "invalid" f=
it
> them all?
>=20

Yes, will change tracing into=20
__entry->valid ? "valid" : "invalid")
and halt_poll_no_tuning --> halt_poll_invalid

That seems to be in line with the remaining parts of the patch.

Christian
