Return-Path: <linux-doc-owner@vger.kernel.org>
Date: Wed, 24 Apr 2019 14:30:02 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 31/79] docs: s390: convert docs to ReST and rename to
 *.rst
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
 <20190424134109.2891a7cc.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424134109.2891a7cc.cohuck@redhat.com>
Message-Id: <20190424123001.GB3990@osiris>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 24, 2019 at 01:41:09PM +0200, Cornelia Huck wrote:
> > diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/debugging390.rst
> > similarity index 53%
> > rename from Documentation/s390/Debugging390.txt
> > rename to Documentation/s390/debugging390.rst
> > index c35804c238ad..d49305fd5e1a 100644
> > --- a/Documentation/s390/Debugging390.txt
> > +++ b/Documentation/s390/debugging390.rst
> 
> I'll skip this one...
> 
> (Question for the s390 arch maintainers: I remember that there was some
> interesting stuff in there, but I'm not sure how much of it is still
> accurate/useful... is it worth spending time on trying to update this?)
> 
> > diff --git a/Documentation/s390/text_files.rst b/Documentation/s390/text_files.rst
> > new file mode 100644
> > index 000000000000..c94d05d4fa17
> > --- /dev/null
> > +++ b/Documentation/s390/text_files.rst
> > @@ -0,0 +1,11 @@
> > +ibm 3270 changelog
> > +------------------
> > +
> > +.. include:: 3270.ChangeLog
> > +    :literal:
> > +
> > +ibm 3270 config3270.sh
> > +----------------------
> > +
> > +.. literalinclude:: config3270.sh
> > +    :language: shell
> 
> 
> Another question for the s390 arch maintainers: How valuable is this still?

...to be honest I consider 80% within Documentation/s390 to be
completely outdated, partially wrong, or irrelevant in the meantime;
the vfio stuff seems to be pretty much up-to-date, and I like the
parts that move comments to code.

Cleaning this up can be done at a later time. I don't want to make
Mauro spend more time than necessary on this.
