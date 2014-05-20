From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Date: Tue, 20 May 2014 09:19:45 +0000
Subject: Fwd: RE: [E1000-devel] [PATCH] fix format mismatch in drivers/net/ethernet/intel/i40e/i40e_debugfs.c
Message-Id: <537B1E31.1030206@gmx.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Ursuly,

related to the usage of u8 versus int/unsigned I forward here an comment from Jeffrey:

-------- Original Message --------
Subject: RE: [E1000-devel] [PATCH] fix format mismatch in drivers/net/ethernet/intel/i40e/i40e_debugfs.c
Date: Tue, 20 May 2014 00:17:07 +0000
From: Nelson, Shannon <shannon.nelson@intel.com>
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>, Toralf F�rster <toralf.foerster@gmx.de>
CC: Brandeburg, Jesse <jesse.brandeburg@intel.com>, e1000-devel@lists.sourceforge.net <e1000-devel@lists.sourceforge.net>, netdev@vger.kernel.org <netdev@vger.kernel.org>

> From: Kirsher, Jeffrey T
> 
> On Mon, 2014-05-19 at 14:04 +0200, Toralf F�rster wrote:
> > spotted by cppcheck
> >
> > Signed-off-by: Toralf F�rster <toralf.foerster@gmx.de>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I will add your patch to my queue and will hold off on making my
> suggested change below until Shannon and Jesse have had time to review
> your patch.
> 
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > index 3c37386..1bc35a2 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > @@ -1239,7 +1239,7 @@ static ssize_t i40e_dbg_command_write(struct
> file *filp,
> >  	} else if (strncmp(cmd_buf, "add pvid", 8) == 0) {
> >  		i40e_status ret;
> >  		u16 vid;
> > -		int v;
> > +		unsigned int v;
> 
> Maybe u16 instead...

sscanf() can be a tricksie little beastie, and I'm more comfortable with giving it an int of some sort rather than a u16, otherwise this would have just used vid from the start.  I can live with Toralf's suggestion.

sln


> 
> >
> >  		cnt = sscanf(&cmd_buf[8], "%i %u", &vsi_seid, &v);
> >  		if (cnt != 2) {
> > @@ -1255,7 +1255,7 @@ static ssize_t i40e_dbg_command_write(struct
> file *filp,
> >  			goto command_write_done;
> >  		}
> >
> > -		vid = (unsigned)v;
> > +		vid = v;
> >  		ret = i40e_vsi_add_pvid(vsi, vid);
> >  		if (!ret)
> >  			dev_info(&pf->pdev->dev,
> 
