Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbgIDMOa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Sep 2020 08:14:30 -0400
Date: Fri, 4 Sep 2020 14:14:22 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390x: Add 3f program exception handler
Message-ID: <20200904121422.GG6075@osiris>
References: <20200903131435.2535-1-frankja@linux.ibm.com>
 <20200903131435.2535-3-frankja@linux.ibm.com>
 <20200904103543.GD6075@osiris>
 <36e1c11c-c4a2-6ae2-b341-7d582203d031@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e1c11c-c4a2-6ae2-b341-7d582203d031@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com

On Fri, Sep 04, 2020 at 01:33:28PM +0200, Janosch Frank wrote:
> >> +	printk_ratelimited(KERN_WARNING
> >> +			   "Secure storage violation in task: %s, pid %d\n",
> >> +			   get_task_comm(buf, current), task_pid_nr(current));
> > 
> > Why get_task_comm() and task_pid_nr() instead of simply current->comm
> > and current->pid?
> 
> Normally if there are functions to get data I assume those should be used.

Could be used, however I don't see why you need that extra complexity
here for both of them.

> > Also: is the dmesg message of any value?
> Yes, it's import for administrators to know that an exception caused
> this segfault and not some memory shenanigans.
> 
> As the exception only occurs if a guest runs in unsupported modes like
> sharing the memory between two secure guests it's a good first
> indication what went wrong.

Yes, fine with me. Just not sure of how help this is when pid
namespaces come into play...
