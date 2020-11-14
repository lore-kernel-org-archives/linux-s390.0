Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34552 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgKNAAd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Nov 2020 19:00:33 -0500
Date: Sat, 14 Nov 2020 01:00:20 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 04/14] s390/zcrypt: driver callback to indicate
 resource in use
Message-ID: <20201114010020.381277c2.pasic@linux.ibm.com>
In-Reply-To: <dcdb9c78-daf8-1f25-f59a-903f0db96ada@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-5-akrowiak@linux.ibm.com>
        <42f3f4f9-6263-cb1e-d882-30b62236a594@linux.ibm.com>
        <dcdb9c78-daf8-1f25-f59a-903f0db96ada@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 13 Nov 2020 16:30:31 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> We will be using the mutex_trylock() function in our sysfs 
> assignment
> interfaces which make the call to the AP bus to check permissions (which 
> also
> locks ap_perms). If the mutex_trylock() fails, we return from the assignment
> function with -EBUSY. This should resolve that potential deadlock issue.

It resolves the deadlock issue only if in_use() is also doing
mutex_trylock(), but the if in_use doesn't take the lock it
needs to back off (and so does it's client code) i.e. a boolean as
return value won't do.

Regards,
Halil
