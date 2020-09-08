Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22352 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728895AbgIHGzj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 02:55:39 -0400
Date: Tue, 8 Sep 2020 08:55:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908085521.4db22680.cohuck@redhat.com>
In-Reply-To: <20200908003951.233e47f3.pasic@linux.ibm.com>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
        <20200908003951.233e47f3.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 8 Sep 2020 00:39:51 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon,  7 Sep 2020 11:39:05 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.  
> 
> Michael, is this going in via your tree?
> 

I believe Michael's tree is the right place for this, but I can also
queue it if I get an ack on patch 1.
