Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH -next 018/491] KERNEL VIRTUAL MACHINE for s390 (KVM/s390):
 Use fallthrough;
References: <cover.1583896344.git.joe@perches.com>
 <d63c86429f3e5aa806aa3e185c97d213904924a5.1583896348.git.joe@perches.com>
Date: Wed, 11 Mar 2020 12:33:20 +0100
MIME-Version: 1.0
In-Reply-To: <d63c86429f3e5aa806aa3e185c97d213904924a5.1583896348.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <26a7b1c0-df95-e706-b8a0-3532f38c7b77@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joe Perches <joe@perches.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 11.03.20 05:51, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

That link does not work. lore asks if this is the right one
https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

Shall I fix that up when applying?
