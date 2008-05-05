From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: s390 kvm_virtio.c build error
Date: Mon, 5 May 2008 14:29:47 +0200
Message-ID: <200805051429.47446.borntraeger@de.ibm.com>
References: <20080503174716.GM5838@cs181133002.pp.htv.fi> <20080504192537.GA5499@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758069AbYEEMaY@vger.kernel.org>
In-Reply-To: <20080504192537.GA5499@osiris.boeblingen.de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Adrian Bunk <bunk@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Avi Kivity <avi@qumranet.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> Hmm... this should help:
> 
> ---
>  drivers/s390/kvm/kvm_virtio.c |   40 
+++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)

Thanks Heiko.
I did a short test and it seems to work.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

This looks almost identical to Rusty's patch. Who is going to send this (or 
Rustys) patch to Linus?

Christian
