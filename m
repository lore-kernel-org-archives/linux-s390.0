Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4F3A785A.4030500@de.ibm.com>
References: <4F3A785A.4030500@de.ibm.com> <20120214145022.12531.16731.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH] KEYS: Enable the compat keyctl wrapper on s390x
Date: Tue, 14 Feb 2012 15:22:38 +0000
Message-ID: <15313.1329232958@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: dhowells@redhat.com, keyrings@linux-nfs.org, linux-kernel@vger.kernel.org, dan@danny.cz, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Do you want to push this change via Martins s390 tree or via other
> trees?

I've no objection to it going via Martin's tree.  It's really an S390 fix
rather than a keyrings/security fix.

David
