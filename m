Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Mar 2015 19:24:58 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] livepatch: add support on s390
In-Reply-To: <1427361017-23354-1-git-send-email-jslaby@suse.cz>
Message-ID: <alpine.LNX.2.00.1503261924430.6781@pobox.suse.cz>
References: <1427361017-23354-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: jpoimboe@redhat.com, sjenning@redhat.com, vojtech@suse.cz, live-patching@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Mar 2015, Jiri Slaby wrote:

> This is a trivial port from kGraft. Module relocations are not
> supported.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> [v2] return ENOSYS
> [v3] proper return value from klp_check_compiler_support

Applied to for-4.1/core.

-- 
Jiri Kosina
SUSE Labs
