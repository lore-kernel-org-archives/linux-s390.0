Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgK3Osv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 09:48:51 -0500
Subject: Re: [PATCH v12 03/17] 390/vfio-ap: use new AP bus interface to search
 for queue devices
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
 <20201124214016.3013-4-akrowiak@linux.ibm.com>
 <20201126113412.62c0f42b.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <7dc9d997-9f58-0d44-6754-01bd62b3eb63@linux.ibm.com>
Date: Mon, 30 Nov 2020 09:48:05 -0500
MIME-Version: 1.0
In-Reply-To: <20201126113412.62c0f42b.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 11/26/20 5:34 AM, Halil Pasic wrote:
> On Tue, 24 Nov 2020 16:40:02 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
> A nit: for all other patches the title prefix is  s390/vfio-ap, here you
> have 390/vfio-ap.

I'll fix that.
