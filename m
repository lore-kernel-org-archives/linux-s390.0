From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/3] arch/s390/kvm: Use GFP_ATOMIC when a lock is held
Date: Mon, 31 May 2010 10:56:26 +0200
Message-ID: <20100531105626.35395a03@mschwide.boeblingen.de.ibm.com>
References: <Pine.LNX.4.64.1005302227470.19253@ask.diku.dk>
	<201005311038.07755.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <201005311038.07755.borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Julia Lawall <julia@diku.dk>, Carsten Otte <cotte@de.ibm.com>, linux390@de.ibm.com, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 31 May 2010 10:38:07 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> > The containing function is called from several places.  At one of them, in
> > the function __sigp_stop, the spin lock &fi->lock is held.
> [...]
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Ok, I'll add the patch to git390. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
