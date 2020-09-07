Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbgIGWkH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 18:40:07 -0400
Date: Tue, 8 Sep 2020 00:39:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908003951.233e47f3.pasic@linux.ibm.com>
In-Reply-To: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Mon,  7 Sep 2020 11:39:05 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Hi all,
> 
> The goal of the series is to give a chance to the architecture
> to validate VIRTIO device features.

Michael, is this going in via your tree?
