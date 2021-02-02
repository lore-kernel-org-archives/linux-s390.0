Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhBBMJL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Feb 2021 07:09:11 -0500
Date: Tue, 2 Feb 2021 13:08:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/2] drivers/misc: sysgenid: add system generation id
 driver
Message-ID: <YBlAueoh12esXR2A@kroah.com>
References: <1612200294-17561-1-git-send-email-acatan@amazon.com>
 <1612200294-17561-2-git-send-email-acatan@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612200294-17561-2-git-send-email-acatan@amazon.com>
List-ID: <linux-s390.vger.kernel.org>
To: Adrian Catangiu <acatan@amazon.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, graf@amazon.com, rdunlap@infradead.org, arnd@arndb.de, ebiederm@xmission.com, rppt@kernel.org, 0x7f454c46@gmail.com, borntraeger@de.ibm.com, Jason@zx2c4.com, jannh@google.com, w@1wt.eu, colmmacc@amazon.com, luto@kernel.org, tytso@mit.edu, ebiggers@kernel.org, dwmw@amazon.co.uk, bonzini@gnu.org, sblbir@amazon.com, raduweis@amazon.com, corbet@lwn.net, mst@redhat.com, mhocko@kernel.org, rafael@kernel.org, pavel@ucw.cz, mpe@ellerman.id.au, areber@redhat.com, ovzxemul@gmail.com, avagin@gmail.com, ptikhomirov@virtuozzo.com, gil@azul.com, asmehra@redhat.com, dgunigun@redhat.com, vijaysun@ca.ibm.com, oridgar@gmail.com, ghammer@redhat.com

On Mon, Feb 01, 2021 at 07:24:53PM +0200, Adrian Catangiu wrote:
> +static long sysgenid_ioctl(struct file *file,
> +						   unsigned int cmd, unsigned long arg)

Very odd indentation style, checkpatch.pl didn't catch this?
