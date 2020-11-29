Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64618 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgK2Aty (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Nov 2020 19:49:54 -0500
Date: Sun, 29 Nov 2020 01:49:04 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 09/17] s390/vfio-ap: sysfs attribute to display the
 guest's matrix
Message-ID: <20201129014904.4fafdbba.pasic@linux.ibm.com>
In-Reply-To: <20201124214016.3013-10-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-10-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 24 Nov 2020 16:40:08 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The matrix of adapters and domains configured in a guest's APCB may
> differ from the matrix of adapters and domains assigned to the matrix mdev,
> so this patch introduces a sysfs attribute to display the matrix of
> adapters and domains that are or will be assigned to the APCB of a guest
> that is or will be using the matrix mdev. For a matrix mdev denoted by
> $uuid, the guest matrix can be displayed as follows:
> 
>    cat /sys/devices/vfio_ap/matrix/$uuid/guest_matrix
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Code looks good, but it may be a little early, since the treatment of
guset_matrix is changed by the following patches.
