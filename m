Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726324AbgDVDKY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 23:10:24 -0400
Subject: Re: [PATCH v3 0/8] s390x/vfio-ccw: Channel Path Handling [KVM]
References: <20200417023001.65006-1-farman@linux.ibm.com>
 <20200421173544.36b48657.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <8acd4662-5a8b-ceda-108f-ed2cfac8dcee@linux.ibm.com>
Date: Tue, 21 Apr 2020 23:10:20 -0400
MIME-Version: 1.0
In-Reply-To: <20200421173544.36b48657.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>



On 4/21/20 11:35 AM, Cornelia Huck wrote:
> On Fri, 17 Apr 2020 04:29:53 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> Here is a new pass at the channel-path handling code for vfio-ccw.
>> Changes from previous versions are recorded in git notes for each patch.
>>
>> I dropped the "Remove inline get_schid()" patch from this version.
>> When I made the change suggested in v2, it seemed rather frivolous and
>> better to just drop it for the time being.
>>
>> I suspect that patches 5 and 7 would be better squashed together, but I
>> have not done that here.  For future versions, I guess.
> 
> The result also might get a bit large.

True.

Not that someone would pick patch 5 and not 7, but vfio-ccw is broken
between them, because of a mismatch in IRQs.  An example from hotplug:

error: internal error: unable to execute QEMU command 'device_add':
vfio: unexpected number of irqs 1

Maybe I just pull the CRW_IRQ definition into 5, and leave the wiring of
the CRW stuff in 7.  That seems to leave a better behavior.

> 
>>
>> With this, and the corresponding QEMU series (to be posted momentarily),
>> applied I am able to configure off/on a CHPID (for example, by issuing
>> "chchp -c 0/1 xx" on the host), and the guest is able to see both the
>> events and reflect the updated path masks in its structures.
> 
> Basically, this looks good to me (modulo my comments).

Woo!  Thanks for the feedback; I'm going to try to get them all
addressed in the next couple of days.

> 
> One thing though that keeps coming up: do we need any kind of
> serialization? Can there be any confusion from concurrent reads from
> userspace, or are we sure that we always provide consistent data?
> 

I'm feeling better with the rearrangement in this version of how we get
data from the queue of CRWs into the region and off to the guest.  The
weirdness I described a few months ago seems to have been triggered by
one of the patches that's now been dropped.  But I'll walk through this
code again once I get your latest comments applied.
