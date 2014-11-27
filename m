Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Nov 2014 17:01:22 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 16/45] KVM: s390: Set virtio-ccw transport revision
Message-ID: <20141127170122.2a1f1e13@thinkpad-w530>
In-Reply-To: <1417091078-24611-17-git-send-email-mst@redhat.com>
References: <1417091078-24611-1-git-send-email-mst@redhat.com>
	<1417091078-24611-17-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, cornelia.huck@de.ibm.com, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> From: Thomas Huth <thuth@linux.vnet.ibm.com>
> 
> With the new SET-VIRTIO-REVISION command of the virtio 1.0 standard, we
> can now negotiate the virtio-ccw revision after setting a channel online.
> 
> Note that we don't negotiate version 1 yet.
> 
> [Cornelia Huck: reworked revision loop a bit]
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Still looks good to me :)
