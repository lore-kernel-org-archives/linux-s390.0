Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETHHv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 May 2020 03:07:51 -0400
Date: Wed, 20 May 2020 09:07:43 +0200
From: Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
Subject: Re: [PATCH] s390/sclp_vt220: Fix console name to match device
Message-ID: <20200520070743.GO4974@valentin-vidic.from.hr>
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
 <65218cdb-d03f-29a8-1e78-42ff2d4f958d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65218cdb-d03f-29a8-1e78-42ff2d4f958d@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed, May 20, 2020 at 07:25:06AM +0200, Christian Borntraeger wrote:
> This is not as simple. ttyS1 is the the console name and ttysclp0 is the tty name.
> This has mostly historic reasons and it obviously causes problems.
> But there is  documentation out that that actually describes the use of 
> console=ttyS1 console=ttyS0.
> to have console output on both sclp consoles and there are probably scripts
> using ttyS1.
> 
> I am wondering. The tty for ttyS0 is named sclp_line0. Does this work in LPAR?

I ran into this problem with qemu-system-s390x, so not sure about LPAR.
Would changing the tty name also cause problems?

-- 
Valentin
