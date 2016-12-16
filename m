Return-Path: <pmladek@suse.com>
Date: Fri, 16 Dec 2016 17:26:42 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 09/15] livepatch: remove unnecessary object loaded check
Message-ID: <20161216162642.GI393@pathway.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <f6bedf84258006261fd2bb632e13d1d1904cda93.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6bedf84258006261fd2bb632e13d1d1904cda93.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-12-08 12:08:34, Josh Poimboeuf wrote:
> klp_patch_object()'s callers already ensure that the object is loaded,
> so its call to klp_is_object_loaded() is unnecessary.
> 
> This will also make it possible to move the patching code into a
> separate file.

Fair enough.

> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
