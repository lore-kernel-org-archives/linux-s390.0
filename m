From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 00/22] guest dedicated crypto adapters
Date: Wed, 22 Aug 2018 12:19:55 +0200
Message-ID: <20180822121955.6767f8d3.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 17:47:57 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Notes:
> =====
> 
> Patches 1-4 (by Harald) posted with this series are forthcoming via
> Martins tree and are based on changes in the ap driver/bus that we use as a
> foundation. They have been included here because some of the functions
> in this patch series are dependent upon them.
> 
> Patches 5-6 (by David) are posted with this series because they are not
> currently in our master branch. Patches 19 and 20 of this series are
> dependent upon them. I believe David's patches are available in the 
> mainline now.

What's the current status of David's patches, BTW?

It's probably easiest to rebase this upon master when the patches have
hit mainline.

I don't have any comments beyond what I already wrote; we'll hopefully
be able to figure out that control domain stuff soon.

Would be great to get some LGTM from the vfio-mdev folks :)

I believe Pierre is also doing some fixing in the existing crypto vsie
code right now?

> 
> This patch series works with the v6 QEMU patches. There is no new QEMU
> patchset version yet because there have been no review comments worthy of
> creating a new series; only a couple of extremely minor nits.

Probably best to repost that once the kernel part is basically through,
if just to solicit more comments.
