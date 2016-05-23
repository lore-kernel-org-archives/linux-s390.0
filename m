Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 May 2016 17:42:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: siginfo memory leak?
Message-ID: <20160523154253.GB8449@redhat.com>
References: <20160523111630.GN2278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523111630.GN2278@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Aleksa Sarai <asarai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/23, Michal Hocko wrote:
>
> x86 do_error_trap doesn't do any initialization at all!

it actually does, please see fill_trap_info() although I'll try to
re-check if it initializes everything we need.

Oleg.
