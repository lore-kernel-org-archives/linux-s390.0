Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Mar 2015 10:04:37 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 1/1] livepatch: add support on s390
Message-ID: <20150324150437.GB24424@treble.redhat.com>
References: <55117A2D.30308@suse.cz>
 <1427208994-6345-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1427208994-6345-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: jkosina@suse.cz, sjenning@redhat.com, vojtech@suse.cz, live-patching@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 24, 2015 at 03:56:34PM +0100, Jiri Slaby wrote:
> This is a trivial port from kGraft. Module relocations are not
> +static inline int klp_write_module_reloc(struct module *mod, unsigned long
> +		type, unsigned long loc, unsigned long value)
> +{
> +	/* not supported yet */
> +	return -EINVAL;

ENOSYS?

-- 
Josh
