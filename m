Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 22 Jul 2018 08:22:48 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] arch/s390: Use new return type vm_fault_t
Message-ID: <20180722152248.GB12125@bombadil.infradead.org>
References: <20180722134109.GA31840@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722134109.GA31840@jordon-HP-15-Notebook-PC>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org, keescook@chromium.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jul 22, 2018 at 07:11:09PM +0530, Souptick Joarder wrote:
> use new return type vm_fault_t for fault handler vdso_fault.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
