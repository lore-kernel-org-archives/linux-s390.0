Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1424422488.5308.21.camel@x220>
Subject: s390: references to MARCH_G5
From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 20 Feb 2015 09:54:48 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, Andreas Ruprecht <rupran@einserver.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Your commit c5f43f0a70fc ("s390: remove 31 bit support") is included in
today's linux-next (ie, next-20150220). I noticed because a script I use
to check linux-next spotted a problem with it.

That commit removed the Kconfig symbol MARCH_G5. It didn't remove all
references to it (there are three left in arch/s390/Kconfig and one in
arch/s390/Makefile). Are patches to remove these last references queued
somewhere?

Thanks,


Paul Bolle
