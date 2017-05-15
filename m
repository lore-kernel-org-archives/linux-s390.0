Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 May 2017 10:09:40 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 28/36] docs-rst: convert s390-drivers DocBook to ReST
In-Reply-To: <bbff6b86ef7a1602870bbce87443bc1a345a83fd.1494596071.git.mchehab@s-opensource.com>
References: <cover.1494596071.git.mchehab@s-opensource.com>
        <bbff6b86ef7a1602870bbce87443bc1a345a83fd.1494596071.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170515100940.66de866c.cornelia.huck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-kernel@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jani Nikula <jani.nikula@intel.com>, Markus Heiser <markus.heiser@darmarit.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.de>, "Herton R. Krzesinski" <herton@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 12 May 2017 11:00:11 -0300
Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:

> Use pandoc to convert documentation to ReST by calling
> Documentation/sphinx/tmplcvt script.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  Documentation/DocBook/Makefile            |   2 +-
>  Documentation/DocBook/s390-drivers.tmpl   | 161 ------------------------------
>  Documentation/driver-api/index.rst        |   1 +
>  Documentation/driver-api/s390-drivers.rst | 111 ++++++++++++++++++++
>  4 files changed, 113 insertions(+), 162 deletions(-)
>  delete mode 100644 Documentation/DocBook/s390-drivers.tmpl
>  create mode 100644 Documentation/driver-api/s390-drivers.rst

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

...but I wonder how good the information in there still is, given that
I haven't touched it in ages...
