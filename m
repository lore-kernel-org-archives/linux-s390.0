From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: correct precise_ip level for s390
Date: Thu, 8 Jun 2017 11:40:02 -0300
Message-ID: <20170608144002.GJ6949@kernel.org>
References: <20170608084044.71968-1-tmricht@linux.vnet.ibm.com>
 <20170608140532.GH6949@kernel.org>
 <20170608142915.GC4444@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170608142915.GC4444@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Thu, Jun 08, 2017 at 04:29:15PM +0200, Hendrik Brueckner escreveu:
> On Thu, Jun 08, 2017 at 11:05:32AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jun 08, 2017 at 10:40:44AM +0200, Thomas Richter escreveu:
> > > Fix this by changing function perf_evsel__new_cycles(). It is called
> > > very early in the event setup. Delay the determination of
> > > the value of precise_ip until the context is known. This is the case
> > > when perf_evsel__config() is called.
> > > Function perf_evsel__new_cycles() just marks precise_ip to be
> > > determined later.

> > > Also change the modifier to 'P' for maximum detected precise level.

> > This "Also" usually indicates that you are folding two changes into one
> > patch, please break it into two, and also send it to the perf
 
> That's usually right.  Except for the change below.  The
> perf_evsel__new_cycles() function constructs a perf event selection.
> The construction includes setting evsel->precise_max and specifying
> the event name string.  To keep setting precise_max and the event name
> in sync, the :P modifier must be set.  This should be part of the same
> commit and not split into two.

Ack, you're right, I'm testing this now, thanks for the patch!

- Arnaldo
