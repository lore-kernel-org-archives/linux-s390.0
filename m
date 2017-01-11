Return-Path: <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 04/15] livepatch/x86: add TIF_PATCH_PENDING thread flag
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <b7bbfce2330e61329056e4567c68be8e4c55fb5b.1481220077.git.jpoimboe@redhat.com>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Wed, 11 Jan 2017 12:36:07 +0530
MIME-Version: 1.0
In-Reply-To: <b7bbfce2330e61329056e4567c68be8e4c55fb5b.1481220077.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f3e38a07-c53b-3860-a59e-2d6f69a2e700@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thursday 08 December 2016 11:38 PM, Josh Poimboeuf wrote:
> Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
> per-task consistency model for x86_64.  The bit getting set indicates
> the thread has a pending patch which needs to be applied when the thread
> exits the kernel.
>
> The bit is placed in the _TIF_ALLWORK_MASK macro, which results in
> exit_to_usermode_loop() calling klp_update_patch_state() when it's set.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
cheers,
Kamalesh.
