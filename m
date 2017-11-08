Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] s390/virtio: mark headers as BSD licensed
References: <1510160307-13235-1-git-send-email-mst@redhat.com>
 <9c2debae-5c00-75ad-bc4d-13af9c4f431d@de.ibm.com>
 <20171108191531.2d2f7210.cohuck@redhat.com>
 <7ab1b0f9-6db2-1d49-3bc6-320e95c71d5b@de.ibm.com>
 <5ea37f22-920e-adc9-e7cf-f901faac92db@de.ibm.com>
 <20171108213424-mutt-send-email-mst@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 8 Nov 2017 20:39:11 +0100
MIME-Version: 1.0
In-Reply-To: <20171108213424-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <93547c07-dfab-70d5-6ed6-aada14670406@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/08/2017 08:35 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 08, 2017 at 07:57:28PM +0100, Christian Borntraeger wrote:
>> So what about the following
>>
>> - leave kvm_virtio.h unchanged and we will delete this file via the s390 tree
> 
> Seems to be used by kvm_virtio.c - are you removing that too?

Yes, so sorry my first url for the git.kernel.org was in the wrong subfolder:
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit?h=features&id=7fb2b2d512448cf0e914c4647a1cf02b52263702


> 
>> - change virtio_ccw.h to BSD license. The content of this file is really really trivial
>> and it boils down to 2 defines, that can be easily reconstructed by looking at the virtio spec.
>> Not even sure if something like this can be copyrighted.
> 
> Yes. What prompted this was Greg's patch.
> 
>>
>> For reference the content of this file minus comments is
>>
>> - snip -
>> #define KVM_VIRTIO_CCW_RING_ALIGN 4096
>> #define KVM_S390_VIRTIO_CCW_NOTIFY 3
>> - snip -
>>
>>

[..]
