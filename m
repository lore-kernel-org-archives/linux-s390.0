Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Feb 2012 17:58:01 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] KEYS: Enable the compat keyctl wrapper on s390x
Message-ID: <20120214165801.GA8108@osiris.boeblingen.de.ibm.com>
References: <4F3A785A.4030500@de.ibm.com>
 <20120214145022.12531.16731.stgit@warthog.procyon.org.uk>
 <15313.1329232958@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15313.1329232958@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, keyrings@linux-nfs.org, linux-kernel@vger.kernel.org, dan@danny.cz, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 14, 2012 at 03:22:38PM +0000, David Howells wrote:
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > Do you want to push this change via Martins s390 tree or via other
> > trees?
> 
> I've no objection to it going via Martin's tree.  It's really an S390 fix
> rather than a keyrings/security fix.

Applied. Thanks!
