Return-Path: <mbenes@suse.cz>
Date: Fri, 27 Jan 2017 09:52:43 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 03/15] livepatch: create temporary
 klp_update_patch_state() stub
In-Reply-To: <e2076a17e3eaa0cafead8208595befbb6e31b0ee.1484839971.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1701270952250.1563@pobox.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <e2076a17e3eaa0cafead8208595befbb6e31b0ee.1484839971.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 Jan 2017, Josh Poimboeuf wrote:

> Create temporary stubs for klp_update_patch_state() so we can add
> TIF_PATCH_PENDING to different architectures in separate patches without
> breaking build bisectability.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
