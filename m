Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgEERar (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 13:30:47 -0400
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
References: <20200504110344.17560-1-eesposit@redhat.com>
 <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
 <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
 <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
 <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
 <alpine.DEB.2.22.394.2005051003380.216575@chino.kir.corp.google.com>
 <6cfdf81f-caef-2489-0906-25915d9d58ff@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <02518c19-59b3-ffbd-cf50-dfdd0d277e0f@de.ibm.com>
Date: Tue, 5 May 2020 19:30:32 +0200
MIME-Version: 1.0
In-Reply-To: <6cfdf81f-caef-2489-0906-25915d9d58ff@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, David Rientjes <rientjes@google.com>
Cc: Jim Mattson <jmattson@google.com>, Emanuele Giuseppe Esposito <eesposit@redhat.com>, Jonathan Adams <jwadams@google.com>, kvm list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Stefan Raspl <raspl@linux.ibm.com>

Adding Stefan Raspl, who has done a lot of kvm_stat work in the past.

On 05.05.20 19:21, Paolo Bonzini wrote:
> On 05/05/20 19:07, David Rientjes wrote:
>>> I am totally in favor of having a binary format, but it should be
>>> introduced as a separate series on top of this one---and preferably by
>>> someone who has already put some thought into the problem (which
>>> Emanuele and I have not, beyond ensuring that the statsfs concept and
>>> API is flexible enough).
>>>
>> The concern is that once this series is merged then /sys/kernel/stats 
>> could be considered an ABI and there would be a reasonable expectation 
>> that it will remain stable, in so far as the stats that userspace is 
>> interested in are stable and not obsoleted.
>>
>> So is this a suggestion that the binary format becomes complementary to 
>> statsfs and provide a means for getting all stats from a single subsystem, 
>> or that this series gets converted to such a format before it is merged?
> 
> The binary format should be complementary.  The ASCII format should
> indeed be considered stable even though individual statistics would come
> and go.  It may make sense to allow disabling ASCII files via mount
> and/or Kconfig options; but either way, the binary format can and should
> be added on top.
> 
> I have not put any thought into what the binary format would look like
> and what its features would be.  For example these are but the first
> questions that come to mind:
> 
> * would it be possible to read/clear an arbitrary statistic with
> pread/pwrite, or do you have to read all of them?
> 
> * if userspace wants to read the schema just once and then read the
> statistics many times, how is it informed of schema changes?
> 
> * and of course the details of how the schema (names of stat and
> subsources) is encoded and what details it should include about the
> values (e.g. type or just signedness).
> 
> Another possibility is to query stats via BPF.  This could be a third
> way to access the stats, or it could be alternative to a binary format.
> 
> Paolo
> 
