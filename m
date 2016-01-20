From: David Miller <davem@davemloft.net>
Subject: Re: SPARC issue
Date: Tue, 19 Jan 2016 21:33:14 -0500 (EST)
Message-ID: <20160119.213314.1236377313729041560.davem@davemloft.net>
References: <20160119.171849.2126169792640472591.davem@davemloft.net>
	<CALCETrXxPdoLBWFbQw179Zvq5Ba4pVb=MGALDy=8GA0oUiXN-w@mail.gmail.com>
	<CALCETrUkm-2bUrj+XHnp_YoP8Ji_VcmE1X4JqfFb4zJOuuZjwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <CALCETrUkm-2bUrj+XHnp_YoP8Ji_VcmE1X4JqfFb4zJOuuZjwQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: luto@amacapital.net
Cc: viro@zeniv.linux.org.uk, luto@kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, keescook@chromium.org
List-ID: <linux-s390.vger.kernel.org>

From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 19 Jan 2016 15:37:17 -0800

> Can we use pt_regs_trap_type for this?

Yes, it could be used to achieve the semantics you are looking for.
