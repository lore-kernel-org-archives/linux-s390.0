Return-Path: <paulus@ozlabs.org>
Date: Thu, 3 Nov 2016 11:50:38 +1100
From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/4] cputime/powerpc: remove cputime_last_delta global
 variable
Message-ID: <20161103005038.GB4764@fergus.ozlabs.ibm.com>
References: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
 <1477917389-11341-2-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477917389-11341-2-git-send-email-sgruszka@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 31, 2016 at 01:36:26PM +0100, Stanislaw Gruszka wrote:
> Since commit:
> 
> cf9efce0ce313 ("powerpc: Account time using timebase rather than PURR")
> 
> cputime_last_delta is not initialized to other value than 0, hence it's
> not used except zero check and cputime_to_scaled() just returns
> the argument.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Yes, I should have removed them in that commit.  We don't want to do
any scaling in the places where cputime_to_scaled() is used.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
