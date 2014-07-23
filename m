Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 Jul 2014 13:18:38 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] s390: Fix me in dasd_eer.c
Message-ID: <20140723131838.36359512@alan.etchedpixels.co.uk>
In-Reply-To: <1406010572-13217-1-git-send-email-xerofoify@gmail.com>
References: <1406010572-13217-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: wein@de.ibm.com, stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 22 Jul 2014 02:29:32 -0400
Nicholas Krause <xerofoify@gmail.com> wrote:

> This patch changes return type to EMEDUIMTYPE in function, dasd_eer_enable
> for when checking if the medium has no errors according to this function.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

What distributions have you tested this with and what configurations?
