From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 1/1] [PATCH] include storage keys in
	hibernation image.
Date: Thu, 16 Jun 2011 01:21:26 +0200
Message-ID: <201106160121.26767.rjw__48883.5189877593$1308180090$gmane$org@sisk.pl>
References: <20110608074523.211912903@de.ibm.com>
	<201106142250.15041.rjw@sisk.pl> <20110615093629.07f01779@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110615093629.07f01779@mschwide>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-pm/>
List-Post: <mailto:linux-pm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wednesday, June 15, 2011, Martin Schwidefsky wrote:
> On Tue, 14 Jun 2011 22:50:14 +0200
...
> > Well, I'm sure we can handle that. :-)
> > 
> > I thought of the following approach:
> > 
> > * Allocate memory for saving the relevant bits of the storage keys before
> >   the memory preallocation kicks in.
> > 
> > * Save the storage key bits to that memory before creating the image (be
> >   careful about the storage keys of the pages they are being stored into).
> > 
> > * After getting control from the boot kernel, restore the storage key bits
> >   saved before creating the image.
> > 
> > * Free additional memory used for storing them.
> > 
> > This way we wouldn't have to worry about any interactions with
> > snapshot_read_next / snapshot_write_next etc.
> 
> Well before the preallocation kicked in we don't know which are the relevant
> storage keys. The only other option would be to store all of them which I
> consider to be a inferior solution. 

OK, I see your point.  You think it's necessary to save the entire storage key
for each page and you'd like to save storage keys only for those pages, whose
contents is going to be saved in the image.

Now, I need to look at your original patch again. :-)
