Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jul 2016 10:39:41 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390/pci: Remove unnecessary if condition
In-Reply-To: <20160729083150.GA8819@amitoj-Inspiron-3542>
References: <20160729083150.GA8819@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.20.1607291037530.3349@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: gerald.schaefer@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Jul 2016, Amitoj Kaur Chawla wrote:
> Remove unnecessary error handling because the only failure value that
> can be returned is NULL and so the test can never be true.
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression e;
> @@
> 
>   e = debugfs_create_file(...);
> - if(IS_ERR(e)) { e = NULL; }

Nope. For !CONFIG_DEBUG_FS debugfs_create_file returns an ERR_PTR.

Regards,
Sebastian
