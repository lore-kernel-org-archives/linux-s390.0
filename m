Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727251AbgKZKeW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 05:34:22 -0500
Date: Thu, 26 Nov 2020 11:34:12 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 03/17] 390/vfio-ap: use new AP bus interface to
 search for queue devices
Message-ID: <20201126113412.62c0f42b.pasic@linux.ibm.com>
In-Reply-To: <20201124214016.3013-4-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-4-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 24 Nov 2020 16:40:02 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

A nit: for all other patches the title prefix is  s390/vfio-ap, here you
have 390/vfio-ap.
