Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgDFWLi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 18:11:38 -0400
Subject: Re: [RFC PATCH v2 7/9] vfio-ccw: Wire up the CRW irq and CRW region
References: <20200206213825.11444-1-farman@linux.ibm.com>
 <20200206213825.11444-8-farman@linux.ibm.com>
 <20200406155255.3c8f06e5.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <66655d37-b9d1-593f-fd81-339b422bb372@linux.ibm.com>
Date: Mon, 6 Apr 2020 18:11:34 -0400
MIME-Version: 1.0
In-Reply-To: <20200406155255.3c8f06e5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 4/6/20 9:52 AM, Cornelia Huck wrote:
> On Thu,  6 Feb 2020 22:38:23 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> Use an IRQ to notify userspace that there is a CRW
>> pending in the region, related to path-availability
>> changes on the passthrough subchannel.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v1->v2:
>>      - Remove extraneous 0x0 in crw.rsid assignment [CH]
>>      - Refactor the building/queueing of a crw into its own routine [EF]
>>     
>>     v0->v1: [EF]
>>      - Place the non-refactoring changes from the previous patch here
>>      - Clean up checkpatch (whitespace) errors
>>      - s/chp_crw/crw/
>>      - Move acquire/release of io_mutex in vfio_ccw_crw_region_read()
>>        into patch that introduces that region
>>      - Remove duplicate include from vfio_ccw_drv.c
>>      - Reorder include in vfio_ccw_private.h
>>
>>  drivers/s390/cio/vfio_ccw_chp.c     |  5 ++
>>  drivers/s390/cio/vfio_ccw_drv.c     | 73 +++++++++++++++++++++++++++++
>>  drivers/s390/cio/vfio_ccw_ops.c     |  4 ++
>>  drivers/s390/cio/vfio_ccw_private.h |  9 ++++
>>  include/uapi/linux/vfio.h           |  1 +
>>  5 files changed, 92 insertions(+)
> 
> [I may have gotten all muddled up from staring at this, but please bear
> with me...]
> 
...snip...
> 
> Aren't we missing copying in a new queued crw after userspace had done
> a read?
> 

Um, huh.  I'll doublecheck that after dinner, but it sure looks like
you're right.

(Might not get back to you tomorrow, because I don't have much time
until Wednesday.)
