Return-Path: <linux-kernel-owner+w=401wt.eu-S1758924AbYLLJqW@vger.kernel.org>
Date: Fri, 12 Dec 2008 10:45:55 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/4] s390: remove s390_root_dev_*()
Message-ID: <20081212104555.055361f5@gondolin>
In-Reply-To: <1229074546.4041.8.camel@blaa>
References: <1229012203.7968.79.camel@blaa>
	<1229012216-4211-1-git-send-email-markmc@redhat.com>
	<1229012216-4211-2-git-send-email-markmc@redhat.com>
	<1229012216-4211-3-git-send-email-markmc@redhat.com>
	<1229012216-4211-4-git-send-email-markmc@redhat.com>
	<20081211180025.045b9b4a@gondolin>
	<20081212102951.01446f22@gondolin>
	<1229074546.4041.8.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mark McLoughlin <markmc@redhat.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <aliguori@us.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 12 Dec 2008 09:35:46 +0000,
Mark McLoughlin <markmc@redhat.com> wrote:

> From: Mark McLoughlin <markmc@redhat.com>
> Subject: [PATCH] s390: remove s390_root_dev_*()
> 
> Replace s390_root_dev_register() with root_device_register() etc.
> 
> [Includes fix from Cornelia Huck]
> 
> Signed-off-by: Mark McLoughlin <markmc@redhat.com>

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
