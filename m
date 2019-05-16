Return-Path: <SRS0=lgIa=TQ=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 16 May 2019 13:44:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 0/7] s390: vfio-ccw fixes
Message-ID: <20190516134440.35be758c.cohuck@redhat.com>
In-Reply-To: <20190514234248.36203-1-farman@linux.ibm.com>
References: <20190514234248.36203-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 May 2019 01:42:41 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> They are based on 5.1.0, not Conny's vfio-ccw tree even though there are
> some good fixes pending for 5.2 there.  I've run this series both with
> and without that code, but couldn't decide which base would provide an
> easier time applying patches.  "I think" they should apply fine to both,
> but I apologize in advance if I guessed wrong!  :)

Patch 2 stumbled over a trivial-to-fix context change; else, things
applied cleanly.

Thanks, queued patches 1-4.
