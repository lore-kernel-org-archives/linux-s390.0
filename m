Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 1 Feb 2019 12:08:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
In-Reply-To: <20190201090159.GC3770@osiris>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
        <alpine.LFD.2.21.1901301912380.2372@schleppi>
        <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
        <20190201090159.GC3770@osiris>
MIME-Version: 1.0
Message-Id: <20190201120822.41d39ddb@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 1 Feb 2019 10:01:59 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
> > On 1/30/19 1:32 PM, Sebastian Ott wrote:  
> > >On Wed, 30 Jan 2019, Tony Krowiak wrote:  
> > >>+#if IS_ENABLED(CONFIG_ZCRYPT)
> > >>+void ap_bus_cfg_chg(void);
> > >>+#else
> > >>+#error "no CONFIG_ZCRYPT"  
> > >    ^
> > >I don't think that's the right thing to do here.  
> > 
> > I'd like to leave it. If somebody edits .config
> > and sets CONFIG_ZCRYPT=n, then the build will
> > fail. The preprocessor error above tells them
> > why.  
> 
> No, the kernel build should never fail if a config option is not set.
> Also the above should be "#ifdef CONFIG_ZCRYPT".
> 
> In addition (this isn't quoted unfortunately) the alternative function
> in the header file is missing the "inline" attribute. Can you please
> add that too?
> 
> static inline void ap_bus_cfg_chg(void) { }
> 
> > >>+* A config change has happened, Force an ap bus rescan.
> > >>+*/
> > >>+void ap_bus_cfg_chg(void)
> > >>+{
> > >>+	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> > >>+
> > >>+	ap_bus_force_rescan();
> > >>+}
> > >>+EXPORT_SYMBOL(ap_bus_cfg_chg);  
> > >
> > >There is no need for the export symbol - you don't call that function
> > >from module code.
> > >As an unrelated question, just to be sure: ap_bus.c is compiled as
> > >built-in even with ZCRYPT=m, right?  
> > 
> > No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
> > into the zcrypt.ko module. Through some other magic, the zcrypt module
> > is loaded when linux boots.  
> 
> If that happens, then we have a build problem that needs to be
> fixed. What exactly are you doing to get the ap code linked into the
> zcrypt module?

Current upstream code:

ap-objs := ap_bus.o ap_card.o ap_queue.o
obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o

The ap_bus.o file is either not build at all or it is linked into the
main kernel image. If ap_bus.o is build then it is guaranteed that
CONFIG_ZCRYPT is either "m" or "y".

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
