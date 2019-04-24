Return-Path: <linux-doc-owner@vger.kernel.org>
Date: Wed, 24 Apr 2019 14:52:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 31/79] docs: s390: convert docs to ReST and rename to
 *.rst
Message-ID: <20190424145251.18e0b3af.cohuck@redhat.com>
In-Reply-To: <20190424094450.1e3da646@coco.lan>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
        <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
        <20190424134109.2891a7cc.cohuck@redhat.com>
        <20190424094450.1e3da646@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 24 Apr 2019 09:44:50 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Em Wed, 24 Apr 2019 13:41:09 +0200
> Cornelia Huck <cohuck@redhat.com> escreveu:
> 
> > On Mon, 22 Apr 2019 10:27:20 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> >   
> > > Convert all text files with s390 documentation to ReST format.
> > > 
> > > Tried to preserve as much as possible the original document
> > > format. Still, some of the files required some work in order
> > > for it to be visible on both plain text and after converted
> > > to html.
> > > 
> > > The conversion is actually:
> > >   - add blank lines and identation in order to identify paragraphs;
> > >   - fix tables markups;
> > >   - add some lists markups;
> > >   - mark literal blocks;
> > >   - adjust title markups.
> > > 
> > > At its new index.rst, let's add a :orphan: while this is not linked to
> > > the main index.rst file, in order to avoid build warnings.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |    4 +-
> > >  Documentation/driver-api/s390-drivers.rst     |    4 +-
> > >  Documentation/s390/{3270.txt => 3270.rst}     |   85 +-
> > >  Documentation/s390/{cds.txt => cds.rst}       |  354 ++-
> > >  .../s390/{CommonIO => common_io.rst}          |   49 +-
> > >  Documentation/s390/{DASD => dasd.rst}         |   33 +-
> > >  .../{Debugging390.txt => debugging390.rst}    | 2389 ++++++++++-------
> > >  .../{driver-model.txt => driver-model.rst}    |  179 +-
> > >  Documentation/s390/index.rst                  |   30 +
> > >  .../s390/{monreader.txt => monreader.rst}     |   85 +-
> > >  Documentation/s390/{qeth.txt => qeth.rst}     |   36 +-
> > >  Documentation/s390/s390dbf.rst                |  803 ++++++
> > >  Documentation/s390/s390dbf.txt                |  667 -----
> > >  Documentation/s390/text_files.rst             |   11 +
> > >  .../s390/{vfio-ap.txt => vfio-ap.rst}         |  487 ++--
> > >  .../s390/{vfio-ccw.txt => vfio-ccw.rst}       |   90 +-
> > >  .../s390/{zfcpdump.txt => zfcpdump.rst}       |    2 +
> > >  MAINTAINERS                                   |    4 +-
> > >  arch/s390/Kconfig                             |    4 +-
> > >  arch/s390/include/asm/debug.h                 |    4 +-
> > >  drivers/s390/char/zcore.c                     |    2 +-
> > >  21 files changed, 3089 insertions(+), 2233 deletions(-)
> > >  rename Documentation/s390/{3270.txt => 3270.rst} (90%)
> > >  rename Documentation/s390/{cds.txt => cds.rst} (64%)
> > >  rename Documentation/s390/{CommonIO => common_io.rst} (87%)
> > >  rename Documentation/s390/{DASD => dasd.rst} (92%)
> > >  rename Documentation/s390/{Debugging390.txt => debugging390.rst} (53%)
> > >  rename Documentation/s390/{driver-model.txt => driver-model.rst} (73%)
> > >  create mode 100644 Documentation/s390/index.rst
> > >  rename Documentation/s390/{monreader.txt => monreader.rst} (81%)
> > >  rename Documentation/s390/{qeth.txt => qeth.rst} (62%)
> > >  create mode 100644 Documentation/s390/s390dbf.rst
> > >  delete mode 100644 Documentation/s390/s390dbf.txt
> > >  create mode 100644 Documentation/s390/text_files.rst
> > >  rename Documentation/s390/{vfio-ap.txt => vfio-ap.rst} (72%)
> > >  rename Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst} (89%)
> > >  rename Documentation/s390/{zfcpdump.txt => zfcpdump.rst} (97%)
> > >     
> > 
> > (...)
> >   
> > > diff --git a/Documentation/s390/3270.txt b/Documentation/s390/3270.rst
> > > similarity index 90%
> > > rename from Documentation/s390/3270.txt
> > > rename to Documentation/s390/3270.rst
> > > index 7c715de99774..e09e77954238 100644
> > > --- a/Documentation/s390/3270.txt
> > > +++ b/Documentation/s390/3270.rst    
> > 
> > (...)
> >   
> > > @@ -17,12 +21,12 @@ twenty and thirty years ago.
> > >  You may have 3270s in-house and not know it.  If you're using the
> > >  VM-ESA operating system, define a 3270 to your virtual machine by using
> > >  the command "DEF GRAF <hex-address>"  This paper presumes you will be
> > > -defining four 3270s with the CP/CMS commands
> > > +defining four 3270s with the CP/CMS commands:
> > >  
> > > -	DEF GRAF 620
> > > -	DEF GRAF 621
> > > -	DEF GRAF 622
> > > -	DEF GRAF 623
> > > +	- DEF GRAF 620
> > > +	- DEF GRAF 621
> > > +	- DEF GRAF 622
> > > +	- DEF GRAF 623    
> > 
> > IIUC, this makes this into a bulleted list... but the user is supposed
> > to enter these commands (similar to the shell commands further down in
> > this file).  
> 
> Ah, OK! I'll change it to use a literal block (::).

Sounds good.


> > > diff --git a/Documentation/s390/CommonIO b/Documentation/s390/common_io.rst
> > > similarity index 87%
> > > rename from Documentation/s390/CommonIO
> > > rename to Documentation/s390/common_io.rst
> > > index 6e0f63f343b4..846485681ce7 100644
> > > --- a/Documentation/s390/CommonIO
> > > +++ b/Documentation/s390/common_io.rst
> > > @@ -1,5 +1,9 @@
> > > -S/390 common I/O-Layer - command line parameters, procfs and debugfs entries
> > > -============================================================================
> > > +======================
> > > +S/390 common I/O-Layer
> > > +======================
> > > +
> > > +command line parameters, procfs and debugfs entries
> > > +===================================================    
> > 
> > I don't see why this should be split into two lines? If anything needs
> > to be changed, I'd drop the hyphen.  
> 
> No real need for html output. I suspect that a big title like the
> above would cause troubles for pdf output. That's basically why I opted
> to break it.
> 
> Yet, if you prefer, I'll keep it as-is.

I basically find the short title confusing (the file is not about the
common I/O layer as a whole, but only about parameters etc.)

Maybe "S/390 common I/O layer user interface"?

But I don't care about this deeply :)

> > > diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.rst
> > > similarity index 89%
> > > rename from Documentation/s390/vfio-ccw.txt
> > > rename to Documentation/s390/vfio-ccw.rst
> > > index 2be11ad864ff..1f6d0b56d53e 100644
> > > --- a/Documentation/s390/vfio-ccw.txt
> > > +++ b/Documentation/s390/vfio-ccw.rst    
> > 
> > (...)
> >   
> > > @@ -295,6 +321,6 @@ Reference
> > >  1. ESA/s390 Principles of Operation manual (IBM Form. No. SA22-7832)
> > >  2. ESA/390 Common I/O Device Commands manual (IBM Form. No. SA22-7204)
> > >  3. https://en.wikipedia.org/wiki/Channel_I/O
> > > -4. Documentation/s390/cds.txt
> > > +4. Documentation/s390/cds.rst  
> 
> > >  5. Documentation/vfio.txt
> > >  6. Documentation/vfio-mediated-device.txt    
> > 
> > Are these two renamed in a later patch?  
> 
> Yes. Patch 56 renames almost all Documentation/*.txt to .rst. Those files
> are already parsed properly by Sphinx, so no changes there are needed.
> 
> I'm working on followup patches (not submitted yet), with moves all
> ReST files under Documentation to some place.
> 
> In the specific case of those files, on the series I'm working,
> I moved them to be part of the driver-api:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames&id=3387ab063cf43f91d5c0f79d741244e7dbcdec05
> 
> The results, when parsed, are at:
> 
> 	https://www.infradead.org/~mchehab/rst_conversion/driver-api/vfio.html
> 	https://www.infradead.org/~mchehab/rst_conversion/driver-api/vfio-mediated-device.html

Sounds good!
