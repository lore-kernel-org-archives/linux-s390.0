Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] s390/virtio: mark headers as BSD licensed
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <1510160307-13235-1-git-send-email-mst@redhat.com>
 <9c2debae-5c00-75ad-bc4d-13af9c4f431d@de.ibm.com>
 <20171108191531.2d2f7210.cohuck@redhat.com>
 <7ab1b0f9-6db2-1d49-3bc6-320e95c71d5b@de.ibm.com>
 <5ea37f22-920e-adc9-e7cf-f901faac92db@de.ibm.com>
Date: Wed, 8 Nov 2017 19:59:56 +0100
MIME-Version: 1.0
In-Reply-To: <5ea37f22-920e-adc9-e7cf-f901faac92db@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1fe445dc-a2ee-3822-7c27-728c525b6d19@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/08/2017 07:57 PM, Christian Borntraeger wrote:
> So what about the following
> 
> - leave kvm_virtio.h unchanged and we will delete this file via the s390 tree
> 
> - change virtio_ccw.h to BSD license. The content of this file is really really trivial

GPLv2 and BSD dual licence might be better I guess.

> and it boils down to 2 defines, that can be easily reconstructed by looking at the virtio spec.
> Not even sure if something like this can be copyrighted.
> 
> 
> For reference the content of this file minus comments is
> 
> - snip -
> #define KVM_VIRTIO_CCW_RING_ALIGN 4096
> #define KVM_S390_VIRTIO_CCW_NOTIFY 3
> - snip -
