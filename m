Return-Path: <sgruszka@redhat.com>
Date: Wed, 2 Nov 2016 10:38:20 +0100
From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH 3/4] cputime/powerpc/s390: make scaled cputime arch
 specific
Message-ID: <20161102093820.GC2604@redhat.com>
References: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
 <1477917389-11341-4-git-send-email-sgruszka@redhat.com>
 <9ad862f2-5665-08d6-4e5d-793637efcb66@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9ad862f2-5665-08d6-4e5d-793637efcb66@de.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 02, 2016 at 10:11:22AM +0100, Christian Borntraeger wrote:
> On 10/31/2016 01:36 PM, Stanislaw Gruszka wrote:
> > Only s390 and powerpc have hardware facilities allowing to measure
> > cputimes scaled by frequency. On all other architectures
> > utimescaled/stimescaled are equal to utime/stime (however they are
> > accounted separately).
> > 
> > Patch remove {u,s}timescaled accounting on all architectures except
> > powerpc and s390, where those values are explicitly accounted on proper
> > places.
> 
> If we remove it everywhere else (and assuming that there are no users then)
> I aks myself if we should remove this as well from s390.

There is one user of scaled cputimes values, it is taskstats (to users
space are exported ac_utimescaled, ac_stimescaled and
cpu_scaled_run_real_total which is calculated based on scaled times).
However on other than powerpc and s390 architectures scaled times are
equal to normal times (this is also true for older powerpc's without
SPURR/PURR registers).

Stanislaw
