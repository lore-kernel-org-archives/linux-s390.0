From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 11/14] s390/ptrace: run seccomp after ptrace
Date: Fri, 10 Jun 2016 12:51:58 +0200
Message-ID: <20160610125158.16dd5497@mschwide>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
        <1465506124-21866-12-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1465506124-21866-12-git-send-email-keescook@chromium.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Ri
List-ID: <linux-s390.vger.kernel.org>

On Thu,  9 Jun 2016 14:02:01 -0700
Kees Cook <keescook@chromium.org> wrote:

> Close the hole where ptrace can change a syscall out from under seccomp.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/ptrace.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

If the change in semantics in regard to the audit of skipped system calls
is acceptable, the modified s390 arch code is ok.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
