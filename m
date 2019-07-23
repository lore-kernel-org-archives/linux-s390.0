Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfGWHzE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jul 2019 03:55:04 -0400
Date: Tue, 23 Jul 2019 09:55:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] vt: Grab console_lock around con_is_bound in show_bind
Message-ID: <20190723075500.GA27243@kroah.com>
References: <20190718080903.22622-1-daniel.vetter@ffwll.ch>
 <20190723073820.GU15868@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723073820.GU15868@phenom.ffwll.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Martin Hostettler <textshell@uchuujin.de>, Adam Borowski <kilobyte@angband.pl>, Mikulas Patocka <mpatocka@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Jul 23, 2019 at 09:38:20AM +0200, Daniel Vetter wrote:
> Hi Greg,
> 
> Do you plan to pick this up in your console/vt/whatever-fixes branch?

Yes, now that the merge window is closed, I will be picking this up.

thanks,

greg k-h
