Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Nov 2014 09:52:26 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 04/46] virtio: add support for 64 bit features.
Message-ID: <20141128095226.44781a98@thinkpad-w530>
In-Reply-To: <1417118789-18231-5-git-send-email-mst@redhat.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-5-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, cornelia.huck@de.ibm.com, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, Rusty Russell <rusty@rustcorp.com.au>, Ohad Ben-Cohen <ohad@wizery.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Siva Yerramreddy <yshivakrishna@gmail.com>, Joel Stanley <joel@jms.id.au>, lguest@lists.ozlabs.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

> Change u32 to u64, and use BIT_ULL and 1ULL everywhere.
> 
> Note: transports are unchanged, and only set low 32 bit.
> This guarantees that no transport sets e.g. VERSION_1
> by mistake without proper support.
> 
> Based on patch by Rusty.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
