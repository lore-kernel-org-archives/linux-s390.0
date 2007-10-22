Return-Path: <linux-kernel-owner+w=401wt.eu-S1754088AbXJVLhu@vger.kernel.org>
Date: Mon, 22 Oct 2007 13:37:23 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] Bug fix for the s390 dcssblk driver
Message-ID: <20071022133723.089b84db@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <471C1D29.5020403@gmail.com>
References: <200710201451.57138.elendil@planet.nl>
	<471A39D2.1070303@gmail.com>
	<20071021100926.GA4420@osiris.ibm.com>
	<471C1D29.5020403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: emist <emistz@gmail.com>
Cc: Linux <linux-kernel@vger.kernel.org>, geraldsc@de.ibm.com, cotte@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, Tejun Heo <htejun@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 21 Oct 2007 23:46:49 -0400,
emist <emistz@gmail.com> wrote:

> # This patch fixes a memory corruption bug in the s390 dcssblk driver.
> # The bug occurs when an attempt to change the type of a segment
> # returns an error. At this point the driver tries to remove the segment in
> # question while some of the device's attributes are in use. This causes the
> # driver to hang.

Hm, seems we missed another of those device attributes exhibiting
suicidal tendencies...

Tejun has a patchset allowing device attributes to commit suicide (see
http://marc.info/?l=linux-kernel&m=119027371416452&w=2), although I'm
not sure what its current status is. Until then, you would need to use
device_schedule_callback() to commit suicide.

This all of course only applies if killing the segment is better than
leaving it in its current state, but others can make a better judgement
on that :)
