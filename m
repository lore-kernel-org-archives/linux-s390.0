Return-Path: <linux-kernel-owner+w=401wt.eu-S1755716AbZCYL7T@vger.kernel.org>
Date: Wed, 25 Mar 2009 12:58:45 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 05/13] [s390] changed ioctls to unlocked
Message-ID: <20090325125845.2923921b@osiris.boeblingen.de.ibm.com>
In-Reply-To: <1237929168-15341-6-git-send-email-stoyboyker@gmail.com>
References: <1237929168-15341-6-git-send-email-stoyboyker@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: stoyboyker@gmail.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 24 Mar 2009 16:12:40 -0500
stoyboyker@gmail.com wrote:

> From: Stoyan Gaydarov <stoyboyker@gmail.com>
> 
> Signed-off-by: Stoyan Gaydarov <stoyboyker@gmail.com>
> ---
>  drivers/s390/char/tape_char.c  |   47 +++++++++++++++++++++++----------
>  drivers/s390/char/vmwatchdog.c |   57 ++++++++++++++++++++++++++--------------
>  2 files changed, 70 insertions(+), 34 deletions(-)

Please resend with the comments that Jonathan made for your other
patches: first define variables then lock_kernel() and also please use
gotos.

Thanks!
