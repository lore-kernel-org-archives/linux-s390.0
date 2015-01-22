From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] s390x: add the proper defines for data types
Date: Thu, 22 Jan 2015 09:52:56 -0800
Message-ID: <CANeU7Qn9jD-ZX2CjSkVTyTu92b9qwM4XZqTOSUB5NDVpAdVMSQ@mail.gmail.com>
References: <1421920310-1499-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
In-Reply-To: <1421920310-1499-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-sparse/>
List-Post: <mailto:linux-sparse@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 22, 2015 at 1:51 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> This patch fixes several issues when compiling code under s390x
> (64bit) with cgcc, e.g.
> /usr/include/gnu/stubs.h:8:12: error: unable to open 'gnu/stubs-32.h'
> by providing the proper defines.


The change looks good. Will apply.

Chris
