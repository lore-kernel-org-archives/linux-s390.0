Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730787AbgKZJf4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 04:35:56 -0500
Date: Thu, 26 Nov 2020 10:35:44 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 01/17] s390/vfio-ap: move probe and remove callbacks
 to vfio_ap_ops.c
Message-ID: <20201126103544.482ddd90.pasic@linux.ibm.com>
In-Reply-To: <20201124214016.3013-2-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-2-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 24 Nov 2020 16:40:00 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Let's move the probe and remove callbacks into the vfio_ap_ops.c
> file to keep all code related to managing queues in a single file. This
> way, all functions related to queue management can be removed from the
> vfio_ap_private.h header file defining the public interfaces for the
> vfio_ap device driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
