From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/5] perf util: Introduce architecture specific
 errno/name mapping
Date: Thu, 18 Jan 2018 13:19:26 +0100
Message-ID: <20180118121926.GA25983@krava>
References: <1516095991-16337-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1516095991-16337-4-git-send-email-brueckner@linux.vnet.ibm.com>
 <20180118100733.GA18567@krava>
 <20180118104953.GA18383@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180118104953.GA18383@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 18, 2018 at 07:49:53AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 18, 2018 at 11:07:33AM +0100, Jiri Olsa escreveu:
> > On Tue, Jan 16, 2018 at 10:46:29AM +0100, Hendrik Brueckner wrote:
> > 
> > SNIP
> > 
> > > index 12dec6e..90ce14f 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -249,7 +249,7 @@ INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
> > >  INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/
> > >  INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/
> > >  
> > > -# $(obj-perf)      for generated common-cmds.h
> > > +# $(obj-perf)      for generated common-cmds.h and errno-names.c
> > >  # $(obj-perf)/util for generated bison/flex headers
> > >  ifneq ($(OUTPUT),)
> > >  INC_FLAGS += -I$(obj-perf)/util
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 9fdefd7..332b4b4 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -518,6 +518,9 @@ $(OUTPUT)common-cmds.h: util/generate-cmdlist.sh command-list.txt
> > >  $(OUTPUT)common-cmds.h: $(wildcard Documentation/perf-*.txt)
> > >  	$(QUIET_GEN). util/generate-cmdlist.sh > $@+ && mv $@+ $@
> > >  
> > > +$(OUTPUT)util/errno-names.c: util/generate-errno-names.sh
> > > +	$(QUIET_GEN). util/generate-errno-names.sh "$(CC)" "$(srctree)/tools" > $@+ && mv $@+ $@
> > 
> > so this generates errno-names.c with following code:
> > 
> > const char *arch_errno_to_name(const char *arch, int err)
> > {
> >         if (!strcmp(arch, "alpha"))
> >                 return errno_to_name__alpha(err);
> >         if (!strcmp(arch, "arm"))
> >                 return errno_to_name__arm(err);
> >         if (!strcmp(arch, "arm64"))
> >                 return errno_to_name__arm64(err);
> > 
> > 
> > is there a reason why we want all archs compiled in?
> > I'd think we just need the arch perf is built in
> 
> think about:
> 
> On an arm64 system:
> 
> 	perf trace record -a sleep 1

oops, forgot we can store in perf trace.. ok then ;-)

thanks,
jirka
