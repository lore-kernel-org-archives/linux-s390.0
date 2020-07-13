Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:36124 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMRdd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jul 2020 13:33:33 -0400
Date: Mon, 13 Jul 2020 11:33:31 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] S390: Replace HTTP links with HTTPS ones
Message-ID: <20200713113331.0f71440d@lwn.net>
In-Reply-To: <20200709182742.24724-1-grandmaster@al2klimov.de>
References: <20200709182742.24724-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu,  9 Jul 2020 20:27:42 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/s390/monreader.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/s390/monreader.rst b/Documentation/s390/monreader.rst
> index 1e857575c113..21cdfb699b49 100644
> --- a/Documentation/s390/monreader.rst
> +++ b/Documentation/s390/monreader.rst
> @@ -146,7 +146,7 @@ start offset relative to a 4K page (frame) boundary.
>  
>  See "Appendix A: `*MONITOR`" in the "z/VM Performance" document for a description
>  of the monitor control element layout. The layout of the monitor records can
> -be found here (z/VM 5.1): http://www.vm.ibm.com/pubs/mon510/index.html
> +be found here (z/VM 5.1): https://www.vm.ibm.com/pubs/mon510/index.html

Applied, thanks.

jon
